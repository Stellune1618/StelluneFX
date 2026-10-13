Shader "StelluneFX/Built-in/Particle Distortion"
{
    Properties
    {
        _DistortionMap ("Distortion Map", 2D) = "gray" {}
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
        GrabPass { "_StelluneFXGrabTexture" }
        Pass
        {
            Blend One Zero
            CGPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_particles
            #pragma shader_feature_local _SOFT_PARTICLES_ON
            #include "UnityCG.cginc"

            sampler2D _DistortionMap;
            float4 _DistortionMap_ST;
            sampler2D _StelluneFXGrabTexture;
            sampler2D_float _CameraDepthTexture;
            half _DistortionStrength, _Blend, _Alpha, _InvFade;
            half4 _DistortionScroll, _TintColor;

            struct appdata_t { float4 vertex : POSITION; fixed4 color : COLOR; float2 uv : TEXCOORD0; UNITY_VERTEX_INPUT_INSTANCE_ID };
            struct v2f { float4 vertex : SV_POSITION; fixed4 color : COLOR; float2 uv : TEXCOORD0; float4 screenPos : TEXCOORD1; UNITY_VERTEX_OUTPUT_STEREO };

            v2f vert(appdata_t v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                o.uv = TRANSFORM_TEX(v.uv, _DistortionMap);
                o.screenPos = ComputeScreenPos(o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                half alpha = i.color.a * _Alpha;
                #if defined(SOFTPARTICLES_ON) || defined(_SOFT_PARTICLES_ON)
                    float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.screenPos)));
                    float particleZ = LinearEyeDepth(i.screenPos.z / i.screenPos.w);
                    alpha *= saturate(_InvFade * (sceneZ - particleZ));
                #endif
                clip(alpha - 0.001);
                float2 screenUV = i.screenPos.xy / i.screenPos.w;
                half2 offset = (tex2D(_DistortionMap, i.uv + _Time.y * _DistortionScroll.xy).rg * 2 - 1) * _DistortionStrength;
                half4 scene = tex2D(_StelluneFXGrabTexture, screenUV + offset);
                half3 tinted = scene.rgb * _TintColor.rgb;
                return fixed4(lerp(scene.rgb, lerp(scene.rgb, tinted, _Blend), alpha), 1);
            }
            ENDCG
        }
    }
    FallBack Off
}
