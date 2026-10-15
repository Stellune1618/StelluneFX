Shader "StelluneFX/Built-in/Particle Distortion"
{
    Properties
    {
        _DistortionMap ("Distortion Map", 2D) = "gray" {}
        _DistortionMask ("Distortion Mask", 2D) = "white" {}
        [Enum(R,0,G,1,B,2,A,3)] _DistortionMaskChannel ("Mask Channel", Float) = 3
        _DistortionMaskStrength ("Mask Strength", Range(0,1)) = 1
        _DistortionStrength ("Distortion Strength", Range(0,0.1)) = 0.02
        _DistortionScroll ("Distortion Scroll", Vector) = (0,0,0,0)
        [HDR] _TintColor ("Tint Color", Color) = (1,1,1,1)
        _Blend ("Distortion Blend", Range(0,1)) = 1
        _Alpha ("Particle Alpha", Range(0,1)) = 1
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Render Face", Float) = 0
        [Toggle(_SOFT_PARTICLES_ON)] _SoftParticles ("Soft Particles", Float) = 0
        _InvFade ("Soft Particle Distance", Range(0.01,10)) = 1
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" "PreviewType"="Plane" }
        Cull [_Cull]
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
        GrabPass { "_StelluneFXGrabTexture" }
        Pass
        {
            CGPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_particles
            #pragma shader_feature_local _SOFT_PARTICLES_ON
            #include "UnityCG.cginc"

            sampler2D _DistortionMap;
            float4 _DistortionMap_ST;
            sampler2D _DistortionMask;
            float4 _DistortionMask_ST;
            sampler2D _StelluneFXGrabTexture;
            sampler2D_float _CameraDepthTexture;
            half _DistortionStrength, _Blend, _Alpha, _InvFade;
            half _DistortionMaskChannel, _DistortionMaskStrength;
            half4 _DistortionScroll, _TintColor;

            struct appdata_t { float4 vertex : POSITION; fixed4 color : COLOR; float2 uv : TEXCOORD0; UNITY_VERTEX_INPUT_INSTANCE_ID };
            struct v2f { float4 vertex : SV_POSITION; fixed4 color : COLOR; float2 uv : TEXCOORD0; float2 maskUV : TEXCOORD2; float4 screenPos : TEXCOORD1; UNITY_VERTEX_OUTPUT_STEREO };

            v2f vert(appdata_t v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                o.uv = TRANSFORM_TEX(v.uv, _DistortionMap);
                o.maskUV = TRANSFORM_TEX(v.uv, _DistortionMask);
                o.screenPos = ComputeScreenPos(o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                half alpha = i.color.a * _Alpha;
                half4 maskSample = tex2D(_DistortionMask, i.maskUV);
                half mask = maskSample.a;
                if (_DistortionMaskChannel < 0.5) mask = maskSample.r;
                else if (_DistortionMaskChannel < 1.5) mask = maskSample.g;
                else if (_DistortionMaskChannel < 2.5) mask = maskSample.b;
                mask = saturate(mask * _DistortionMaskStrength);

                #if defined(SOFTPARTICLES_ON) || defined(_SOFT_PARTICLES_ON)
                    float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.screenPos)));
                    float particleZ = LinearEyeDepth(i.screenPos.z / i.screenPos.w);
                    alpha *= saturate(_InvFade * (sceneZ - particleZ));
                #endif

                alpha = saturate(alpha * mask);
                clip(alpha - 0.001);

                float2 screenUV = i.screenPos.xy / i.screenPos.w;
                half2 offset = (tex2D(_DistortionMap, i.uv + _Time.y * _DistortionScroll.xy).rg * 2 - 1) * _DistortionStrength;
                half3 distorted = tex2D(_StelluneFXGrabTexture, screenUV + offset).rgb;
                half3 tinted = distorted * _TintColor.rgb;
                half3 effect = lerp(distorted, tinted, _Blend);

                // The particle alpha is used as the actual screen-space effect opacity.
                // This makes Color over Lifetime and soft particles affect distortion
                // continuously instead of only affecting a tint/clip threshold.
                return fixed4(effect, alpha);
            }
            ENDCG
        }
    }
    FallBack Off
}

