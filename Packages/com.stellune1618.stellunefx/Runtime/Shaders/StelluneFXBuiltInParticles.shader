Shader "StelluneFX/Built-in/Particles"
{
    Properties
    {
        [MainTexture] _BaseMap ("Base Map", 2D) = "white" {}
        [HDR] _Color ("Color", Color) = (1,1,1,1)
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Source Blend", Float) = 5
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Destination Blend", Float) = 10
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Render Face", Float) = 0
        [Toggle] _ZWrite ("Z Write", Float) = 0
        [Toggle] _UseParticleFlipbook ("Use Particle Texture Sheet", Float) = 0

        _BaseMapRotation ("Base Map Rotation", Range(0,1)) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _BaseMapRotationCoord ("Base Map Rotation Coord", Float) = 0
        _BaseMapRotationOffsets ("Base Map Rotation Offset", Vector) = (0.5,0.5,0,0)

        [Header(Flow Map)]
        _FlowMap ("Flow Map", 2D) = "gray" {}
        _FlowMapScroll ("Flow Scroll", Vector) = (0,0,0,0)
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _FlowMapScrollXCoord ("Flow Scroll X Coord", Float) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _FlowMapScrollYCoord ("Flow Scroll Y Coord", Float) = 0
        _FlowMapStrength ("Flow Strength", Range(0,1)) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _FlowMapStrengthCoord ("Flow Strength Coord", Float) = 0
        [Enum(None,0,Base,1,Tint,2,Base And Tint,3,Dissolve,4)] _FlowTarget ("Flow Target", Float) = 1

        [Header(Tint)]
        [Enum(None,0,Color,1,Texture,2,Color And Texture,3,Rim,4)] _TintMode ("Tint Mode", Float) = 1
        [HDR] _TintColor ("Tint Color", Color) = (1,1,1,1)
        _TintMap ("Tint Map", 2D) = "white" {}
        _TintMapStrength ("Tint Map Strength", Range(0,1)) = 1
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _TintMapStrengthCoord ("Tint Map Strength Coord", Float) = 0
        _TintRimPower ("Tint Rim Power", Range(0.1,8)) = 2
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _TintRimPowerCoord ("Tint Rim Power Coord", Float) = 0
        _TintMapRotation ("Tint Map Rotation", Range(0,1)) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _TintMapRotationCoord ("Tint Map Rotation Coord", Float) = 0
        _TintMapRotationOffsets ("Tint Map Rotation Offset", Vector) = (0.5,0.5,0,0)

        [Header(Tone)]
        [Enum(None,0,Tritone,1,Pentone,2)] _ToneMode ("Tone Mode", Float) = 0
        _ToneShadows ("Shadows", Color) = (0,0,0,1)
        _ToneMidtones ("Midtones", Color) = (0.5,0.5,0.5,1)
        _ToneHighlights ("Highlights", Color) = (1,1,1,1)
        _ToneShadowBoundary ("Shadow Boundary", Range(0,1)) = 0.25
        _ToneMidBoundary ("Mid Boundary", Range(0,1)) = 0.5
        _ToneHighlightBoundary ("Highlight Boundary", Range(0,1)) = 0.75
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _ToneShadowBoundaryCoord ("Shadow Boundary Coord", Float) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _ToneMidBoundaryCoord ("Mid Boundary Coord", Float) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _ToneHighlightBoundaryCoord ("Highlight Boundary Coord", Float) = 0

        [Header(Dissolve And Fade)]
        [Enum(Off,0,Fade,1,Dissolve,2)] _TransitionMode ("Transition Mode", Float) = 0
        _TransitionMap ("Transition Map", 2D) = "white" {}
        _TransitionProgress ("Transition Progress", Range(0,1)) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _TransitionProgressCoord ("Transition Progress Coord", Float) = 0
        _TransitionSharpness ("Transition Sharpness", Range(0.001,1)) = 0.1
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _TransitionSharpnessCoord ("Transition Sharpness Coord", Float) = 0
        _TransitionEdgeWidth ("Edge Width", Range(0.001,1)) = 0.05
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _TransitionEdgeWidthCoord ("Edge Width Coord", Float) = 0
        [HDR] _TransitionEdgeColor ("Edge Color", Color) = (1,0.25,0.02,1)

        [Header(Emission)]
        _EmissionMap ("Emission Map", 2D) = "black" {}
        [HDR] _EmissionColor ("Emission Color", Color) = (0,0,0,1)
        _EmissionIntensity ("Emission Intensity", Range(0,20)) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _EmissionIntensityCoord ("Emission Intensity Coord", Float) = 0

        [Header(Transparency)]
        [Toggle] _RimTransparency ("Rim Transparency", Float) = 0
        _RimTransparencyPower ("Rim Transparency Power", Range(0.1,8)) = 2
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _RimTransparencyPowerCoord ("Rim Transparency Power Coord", Float) = 0
        [Toggle] _LuminanceTransparency ("Luminance Transparency", Float) = 0
        _LuminanceTransparencyPower ("Luminance Transparency Power", Range(0.1,8)) = 1
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _LuminanceTransparencyPowerCoord ("Luminance Transparency Power Coord", Float) = 0

        [Header(Depth And Camera Fade)]
        [Toggle(_SOFT_PARTICLES_ON)] _SoftParticles ("Soft Particles", Float) = 0
        _InvFade ("Soft Particle Distance", Range(0.01,10)) = 1
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _InvFadeCoord ("Soft Particle Distance Coord", Float) = 0
        [Toggle] _CameraFade ("Camera Fade", Float) = 0
        _CameraFadeNear ("Camera Fade Near", Float) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _CameraFadeNearCoord ("Camera Fade Near Coord", Float) = 0
        _CameraFadeFar ("Camera Fade Far", Float) = 1
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _CameraFadeFarCoord ("Camera Fade Far Coord", Float) = 0

        [Header(Vertex Deformation)]
        [Toggle] _VertexDeformation ("Vertex Deformation", Float) = 0
        _VertexDeformationMap ("Deformation Map", 2D) = "gray" {}
        _VertexDeformationIntensity ("Deformation Intensity", Float) = 0
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _VertexDeformationIntensityCoord ("Deformation Intensity Coord", Float) = 0
        _VertexDeformationBase ("Deformation Base", Range(0,1)) = 0.5
        [Enum(Unused,0,Coord1X,1,Coord1Y,11,Coord1Z,21,Coord1W,31,Coord2X,2,Coord2Y,12,Coord2Z,22,Coord2W,32)] _VertexDeformationBaseCoord ("Deformation Base Coord", Float) = 0
        [Enum(R,0,G,1,B,2,A,3)] _VertexDeformationChannel ("Deformation Channel", Float) = 0

        [Header(Cutout)]
        [Toggle] _AlphaClip ("Alpha Clip", Float) = 0
        _Cutoff ("Cutoff", Range(0,1)) = 0.5
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" "PreviewType"="Plane" }
        Blend [_SrcBlend] [_DstBlend]
        ZWrite [_ZWrite]
        Cull [_Cull]
        Lighting Off
        Fog { Mode Off }

        Pass
        {
            CGPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_particles
            #pragma multi_compile_fog
            #pragma shader_feature_local _SOFT_PARTICLES_ON
            #include "UnityCG.cginc"

            sampler2D _BaseMap;
            float4 _BaseMap_ST;
            sampler2D _FlowMap;
            float4 _FlowMap_ST;
            sampler2D _TintMap;
            float4 _TintMap_ST;
            sampler2D _TransitionMap;
            float4 _TransitionMap_ST;
            sampler2D _EmissionMap;
            float4 _EmissionMap_ST;
            sampler2D _VertexDeformationMap;
            float4 _VertexDeformationMap_ST;
            sampler2D_float _CameraDepthTexture;

            half4 _Color, _TintColor, _ToneShadows, _ToneMidtones, _ToneHighlights;
            half4 _TransitionEdgeColor, _EmissionColor;
            half _UseParticleFlipbook, _FlowMapStrength, _FlowTarget;
            half4 _FlowMapScroll;
            half _TintMode, _TintMapStrength, _TintRimPower;
            half _ToneMode, _ToneShadowBoundary, _ToneMidBoundary, _ToneHighlightBoundary;
            half _TransitionMode, _TransitionProgress, _TransitionSharpness, _TransitionEdgeWidth;
            half _EmissionIntensity;
            half _RimTransparency, _RimTransparencyPower, _LuminanceTransparency, _LuminanceTransparencyPower;
            half _InvFade, _CameraFade, _CameraFadeNear, _CameraFadeFar;
            half _VertexDeformation, _VertexDeformationIntensity, _VertexDeformationBase, _VertexDeformationChannel;
            half _AlphaClip, _Cutoff;
            half _BaseMapRotation, _BaseMapRotationCoord;
            half4 _BaseMapRotationOffsets;
            half _FlowMapScrollXCoord, _FlowMapScrollYCoord, _FlowMapStrengthCoord;
            half _TintMapStrengthCoord, _TintRimPowerCoord, _TintMapRotation, _TintMapRotationCoord;
            half4 _TintMapRotationOffsets;
            half _ToneShadowBoundaryCoord, _ToneMidBoundaryCoord, _ToneHighlightBoundaryCoord;
            half _TransitionProgressCoord, _TransitionSharpnessCoord, _TransitionEdgeWidthCoord;
            half _EmissionIntensityCoord, _RimTransparencyPowerCoord, _LuminanceTransparencyPowerCoord;
            half _InvFadeCoord, _CameraFadeNearCoord, _CameraFadeFarCoord;
            half _VertexDeformationIntensityCoord, _VertexDeformationBaseCoord;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                fixed4 color : COLOR;
                float4 texcoords : TEXCOORD0; // UV and UV2 when Texture Sheet Animation is enabled.
                float texcoordBlend : TEXCOORD1; // AnimBlend.
                float4 custom1 : TEXCOORD2; // Custom1XYZW, optional.
                float4 custom2 : TEXCOORD3; // Custom2XYZW, optional.
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR0;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float animBlend : TEXCOORD2;
                float4 custom1 : TEXCOORD3;
                float4 custom2 : TEXCOORD4;
                float3 worldPos : TEXCOORD5;
                float3 worldNormal : TEXCOORD6;
                float4 screenPos : TEXCOORD7;
                UNITY_FOG_COORDS(8)
                UNITY_VERTEX_OUTPUT_STEREO
            };

            half SelectChannel(half4 value, half channel)
            {
                if (channel < 0.5) return value.r;
                if (channel < 1.5) return value.g;
                if (channel < 2.5) return value.b;
                return value.a;
            }

            // 1/11/21/31 = Custom1.x/y/z/w and 2/12/22/32 = Custom2.x/y/z/w.
            half ReadCustomCoord(half coord, half4 custom1, half4 custom2)
            {
                int c = (int)(coord + 0.5h);
                if (c == 1) return custom1.x;
                if (c == 11) return custom1.y;
                if (c == 21) return custom1.z;
                if (c == 31) return custom1.w;
                if (c == 2) return custom2.x;
                if (c == 12) return custom2.y;
                if (c == 22) return custom2.z;
                if (c == 32) return custom2.w;
                return 0;
            }

            half ResolveCustom(half materialValue, half coord, half4 custom1, half4 custom2)
            {
                return coord > 0.5h ? ReadCustomCoord(coord, custom1, custom2) : materialValue;
            }

            float2 RotateUV(float2 uv, half angle, half2 center)
            {
                half s = sin(angle);
                half c = cos(angle);
                uv -= center;
                return float2(uv.x * c - uv.y * s, uv.x * s + uv.y * c) + center;
            }

            v2f vert(appdata_t v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                float3 vertexOS = v.vertex.xyz;
                if (_VertexDeformation > 0.5)
                {
                    half4 deformation = tex2Dlod(_VertexDeformationMap, float4(TRANSFORM_TEX(v.texcoords.xy, _VertexDeformationMap), 0, 0));
                    half deformationBase = ResolveCustom(_VertexDeformationBase, _VertexDeformationBaseCoord, v.custom1, v.custom2);
                    half deformationIntensity = ResolveCustom(_VertexDeformationIntensity, _VertexDeformationIntensityCoord, v.custom1, v.custom2);
                    vertexOS += v.normal * (SelectChannel(deformation, _VertexDeformationChannel) - deformationBase) * deformationIntensity;
                }

                o.vertex = UnityObjectToClipPos(float4(vertexOS, 1));
                o.color = v.color * _Color;
                half baseRotation = ResolveCustom(_BaseMapRotation, _BaseMapRotationCoord, v.custom1, v.custom2) * 6.2831853h;
                float2 baseUV0 = RotateUV(v.texcoords.xy, baseRotation, _BaseMapRotationOffsets.xy);
                float2 baseUV1 = RotateUV(v.texcoords.zw, baseRotation, _BaseMapRotationOffsets.xy);
                o.uv0 = TRANSFORM_TEX(baseUV0, _BaseMap);
                o.uv1 = TRANSFORM_TEX(baseUV1, _BaseMap);
                o.animBlend = saturate(v.texcoordBlend);
                o.custom1 = v.custom1;
                o.custom2 = v.custom2;
                o.worldPos = mul(unity_ObjectToWorld, float4(vertexOS, 1)).xyz;
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.screenPos = ComputeScreenPos(o.vertex);
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            half3 ApplyTone(half3 color)
            {
                if (_ToneMode < 0.5) return color;
                half luminance = dot(color, half3(0.299, 0.587, 0.114));
                if (_ToneMode < 1.5)
                {
                    half3 low = lerp(_ToneShadows.rgb, _ToneMidtones.rgb, saturate((luminance - _ToneShadowBoundary) / max(_ToneMidBoundary - _ToneShadowBoundary, 0.001)));
                    half3 high = lerp(_ToneMidtones.rgb, _ToneHighlights.rgb, saturate((luminance - _ToneMidBoundary) / max(_ToneHighlightBoundary - _ToneMidBoundary, 0.001)));
                    return lerp(low, high, step(_ToneMidBoundary, luminance));
                }
                half3 shadows = lerp(_ToneShadows.rgb, _ToneMidtones.rgb, smoothstep(_ToneShadowBoundary, _ToneMidBoundary, luminance));
                half3 highlights = lerp(_ToneMidtones.rgb, _ToneHighlights.rgb, smoothstep(_ToneMidBoundary, _ToneHighlightBoundary, luminance));
                return lerp(shadows, highlights, smoothstep(_ToneShadowBoundary, _ToneHighlightBoundary, luminance));
            }

            half SoftParticleFade(v2f i, half invFade)
            {
                #if defined(SOFTPARTICLES_ON) || defined(_SOFT_PARTICLES_ON)
                    float sceneZ = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.screenPos)));
                    float particleZ = i.screenPos.z / i.screenPos.w;
                    return saturate(invFade * (sceneZ - LinearEyeDepth(particleZ)));
                #else
                    return 1;
                #endif
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 uv = lerp(i.uv0, i.uv1, (_UseParticleFlipbook > 0.5) ? i.animBlend : 0);
                half flowScrollX = ResolveCustom(_FlowMapScroll.x, _FlowMapScrollXCoord, i.custom1, i.custom2);
                half flowScrollY = ResolveCustom(_FlowMapScroll.y, _FlowMapScrollYCoord, i.custom1, i.custom2);
                half flowStrength = ResolveCustom(_FlowMapStrength, _FlowMapStrengthCoord, i.custom1, i.custom2);
                float2 flowUV = TRANSFORM_TEX(i.uv0, _FlowMap) + _Time.y * float2(flowScrollX, flowScrollY);
                half2 flow = (tex2D(_FlowMap, flowUV).rg * 2.0 - 1.0) * flowStrength;
                bool flowBase = (_FlowTarget > 0.5 && _FlowTarget < 1.5) || (_FlowTarget > 2.5 && _FlowTarget < 3.5);
                bool flowTint = (_FlowTarget > 1.5 && _FlowTarget < 3.5);
                bool flowTransition = (_FlowTarget > 3.5);
                if (flowBase) uv += flow;

                fixed4 baseSample = tex2D(_BaseMap, uv);
                half3 color = baseSample.rgb;
                half alpha = baseSample.a * i.color.a;

                half tintMapStrength = ResolveCustom(_TintMapStrength, _TintMapStrengthCoord, i.custom1, i.custom2);
                half tintRimPower = ResolveCustom(_TintRimPower, _TintRimPowerCoord, i.custom1, i.custom2);
                half tintRotation = ResolveCustom(_TintMapRotation, _TintMapRotationCoord, i.custom1, i.custom2) * 6.2831853h;
                float2 tintUV = TRANSFORM_TEX(RotateUV(i.uv0, tintRotation, _TintMapRotationOffsets.xy), _TintMap) + (flowTint ? flow : 0);
                half3 tint = _TintColor.rgb;
                if (_TintMode > 1.5 && _TintMode < 3.5) tint *= lerp(1, tex2D(_TintMap, tintUV).rgb, tintMapStrength);
                if (_TintMode > 3.5)
                {
                    half rim = pow(saturate(1 - dot(normalize(i.worldNormal), normalize(_WorldSpaceCameraPos - i.worldPos))), tintRimPower);
                    tint = lerp(1, _TintColor.rgb, rim);
                }
                if (_TintMode > 0.5) color *= tint;
                color = ApplyTone(color);

                float2 transitionUV = TRANSFORM_TEX(i.uv0, _TransitionMap) + (flowTransition ? flow : 0);
                half transitionMask = tex2D(_TransitionMap, transitionUV).r;
                half edge = 0;
                if (_TransitionMode > 0.5)
                {
                    half transitionProgress = ResolveCustom(_TransitionProgress, _TransitionProgressCoord, i.custom1, i.custom2);
                    half transitionSharpness = ResolveCustom(_TransitionSharpness, _TransitionSharpnessCoord, i.custom1, i.custom2);
                    half transitionEdgeWidth = ResolveCustom(_TransitionEdgeWidth, _TransitionEdgeWidthCoord, i.custom1, i.custom2);
                    half width = max(transitionSharpness, 0.001);
                    half mask = smoothstep(transitionProgress - width, transitionProgress + width, transitionMask);
                    edge = 1 - smoothstep(transitionProgress, transitionProgress + transitionEdgeWidth, transitionMask);
                    if (_TransitionMode > 1.5) clip(mask - 0.001);
                    else alpha *= mask;
                }
                color += _TransitionEdgeColor.rgb * edge * _TransitionEdgeColor.a;

                half emissionIntensity = ResolveCustom(_EmissionIntensity, _EmissionIntensityCoord, i.custom1, i.custom2);
                half3 emission = tex2D(_EmissionMap, TRANSFORM_TEX(i.uv0, _EmissionMap)).rgb * _EmissionColor.rgb * emissionIntensity;
                color += emission;

                half luminance = dot(saturate(color), half3(0.299, 0.587, 0.114));
                half rimTransparencyPower = ResolveCustom(_RimTransparencyPower, _RimTransparencyPowerCoord, i.custom1, i.custom2);
                half luminanceTransparencyPower = ResolveCustom(_LuminanceTransparencyPower, _LuminanceTransparencyPowerCoord, i.custom1, i.custom2);
                if (_RimTransparency > 0.5)
                {
                    half rim = pow(saturate(1 - dot(normalize(i.worldNormal), normalize(_WorldSpaceCameraPos - i.worldPos))), rimTransparencyPower);
                    alpha *= rim;
                }
                if (_LuminanceTransparency > 0.5) alpha *= pow(saturate(luminance), luminanceTransparencyPower);
                half softParticleDistance = ResolveCustom(_InvFade, _InvFadeCoord, i.custom1, i.custom2);
                alpha *= SoftParticleFade(i, softParticleDistance);
                if (_CameraFade > 0.5)
                {
                    half distanceToCamera = distance(_WorldSpaceCameraPos, i.worldPos);
                    half cameraFadeNear = ResolveCustom(_CameraFadeNear, _CameraFadeNearCoord, i.custom1, i.custom2);
                    half cameraFadeFar = ResolveCustom(_CameraFadeFar, _CameraFadeFarCoord, i.custom1, i.custom2);
                    alpha *= saturate((distanceToCamera - cameraFadeNear) / max(cameraFadeFar - cameraFadeNear, 0.001));
                }

                if (_AlphaClip > 0.5) clip(alpha - _Cutoff);
                fixed4 result = fixed4(color * i.color.rgb, alpha);
                UNITY_APPLY_FOG(i.fogCoord, result);
                return result;
            }
            ENDCG
        }
    }
    CustomEditor "StelluneFX.BuiltIn.StelluneFXBuiltInParticlesGUI"
    FallBack "Particles/Alpha Blended"
}
