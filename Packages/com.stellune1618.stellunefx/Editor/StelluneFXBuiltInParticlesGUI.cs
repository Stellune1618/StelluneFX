using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace StelluneFX.BuiltIn
{
    /// <summary>
    /// Inspector layout for StelluneFX/Built-in/Particles.
    /// </summary>
    public sealed class StelluneFXBuiltInParticlesGUI : ShaderGUI
    {
        private enum CustomCoord
        {
            Unused = 0,
            Coord1X = 1,
            Coord1Y = 11,
            Coord1Z = 21,
            Coord1W = 31,
            Coord2X = 2,
            Coord2Y = 12,
            Coord2Z = 22,
            Coord2W = 32
        }

        private static readonly Dictionary<string, bool> Foldouts = new Dictionary<string, bool>();
        private readonly Dictionary<string, MaterialProperty> _properties = new Dictionary<string, MaterialProperty>();
        private static GUIStyle _sectionFoldoutStyle;
        private static GUIStyle _sectionContentsStyle;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
        {
            _properties.Clear();
            foreach (MaterialProperty property in properties) _properties[property.name] = property;

            Section("Render Settings", () =>
            {
                Prop(materialEditor, "_Color", "Color");
                Prop(materialEditor, "_SrcBlend", "Source Blend");
                Prop(materialEditor, "_DstBlend", "Destination Blend");
                Prop(materialEditor, "_Cull", "Render Face");
                Prop(materialEditor, "_ZWrite", "Z Write");
                Prop(materialEditor, "_AlphaClip", "Alpha Clip");
                Prop(materialEditor, "_Cutoff", "Cutoff");
            });

            Section("Vertex Deformation", () =>
            {
                Prop(materialEditor, "_VertexDeformation", "Enabled");
                Texture(materialEditor, "_VertexDeformationMap", "Texture");
                Custom(materialEditor, "_VertexDeformationIntensity", "_VertexDeformationIntensityCoord", "Intensity");
                Custom(materialEditor, "_VertexDeformationBase", "_VertexDeformationBaseCoord", "Base Value");
                Prop(materialEditor, "_VertexDeformationChannel", "Channel");
            });

            Section("Base Map", () =>
            {
                Texture(materialEditor, "_BaseMap", "Texture");
                Prop(materialEditor, "_UseParticleFlipbook", "Use Particle Texture Sheet");
                Custom(materialEditor, "_BaseMapRotation", "_BaseMapRotationCoord", "Rotation");
                Prop(materialEditor, "_BaseMapRotationOffsets", "Rotation Offset");
            });

            Section("Tint Color", () =>
            {
                Prop(materialEditor, "_TintMode", "Mode");
                Prop(materialEditor, "_TintColor", "Color");
                Texture(materialEditor, "_TintMap", "Texture");
                Custom(materialEditor, "_TintMapStrength", "_TintMapStrengthCoord", "Blend Rate");
                Custom(materialEditor, "_TintRimPower", "_TintRimPowerCoord", "Rim Sharpness");
                Custom(materialEditor, "_TintMapRotation", "_TintMapRotationCoord", "Rotation");
                Prop(materialEditor, "_TintMapRotationOffsets", "Rotation Offset");
            });

            Section("Flow Map", () =>
            {
                Texture(materialEditor, "_FlowMap", "Texture");
                Prop(materialEditor, "_FlowMapScroll", "Flow Scroll");
                CoordOnly(materialEditor, "Scroll X Coord", "_FlowMapScrollXCoord");
                CoordOnly(materialEditor, "Scroll Y Coord", "_FlowMapScrollYCoord");
                Custom(materialEditor, "_FlowMapStrength", "_FlowMapStrengthCoord", "Intensity");
                Prop(materialEditor, "_FlowTarget", "Target");
            });

            Section("Parallax Map", () =>
            {
                EditorGUILayout.HelpBox("Parallax Map is not included in the Built-in first-pass trace.", MessageType.Info);
            });

            Section("Color Correction", () =>
            {
                Prop(materialEditor, "_ToneMode", "Mode");
                Prop(materialEditor, "_ToneShadows", "Shadows");
                Prop(materialEditor, "_ToneMidtones", "Midtones");
                Prop(materialEditor, "_ToneHighlights", "Highlights");
                Custom(materialEditor, "_ToneShadowBoundary", "_ToneShadowBoundaryCoord", "Shadow Boundary");
                Custom(materialEditor, "_ToneMidBoundary", "_ToneMidBoundaryCoord", "Mid Boundary");
                Custom(materialEditor, "_ToneHighlightBoundary", "_ToneHighlightBoundaryCoord", "Highlight Boundary");
            });

            Section("Alpha Transition", () =>
            {
                Prop(materialEditor, "_TransitionMode", "Mode");
                Texture(materialEditor, "_TransitionMap", "Transition Map");
                Custom(materialEditor, "_TransitionProgress", "_TransitionProgressCoord", "Progress");
                Custom(materialEditor, "_TransitionSharpness", "_TransitionSharpnessCoord", "Sharpness");
                Custom(materialEditor, "_TransitionEdgeWidth", "_TransitionEdgeWidthCoord", "Edge Width");
                Prop(materialEditor, "_TransitionEdgeColor", "Edge Color");
            });

            Section("Emission", () =>
            {
                Texture(materialEditor, "_EmissionMap", "Texture");
                Prop(materialEditor, "_EmissionColor", "Color");
                Custom(materialEditor, "_EmissionIntensity", "_EmissionIntensityCoord", "Intensity");
            });

            Section("Transparency", () =>
            {
                Prop(materialEditor, "_RimTransparency", "Rim Transparency");
                Custom(materialEditor, "_RimTransparencyPower", "_RimTransparencyPowerCoord", "Rim Power");
                Prop(materialEditor, "_LuminanceTransparency", "Luminance Transparency");
                Custom(materialEditor, "_LuminanceTransparencyPower", "_LuminanceTransparencyPowerCoord", "Luminance Power");
                Prop(materialEditor, "_SoftParticles", "Soft Particles");
                Custom(materialEditor, "_InvFade", "_InvFadeCoord", "Soft Particle Distance");
                Prop(materialEditor, "_CameraFade", "Camera Fade");
                Custom(materialEditor, "_CameraFadeNear", "_CameraFadeNearCoord", "Camera Fade Near");
                Custom(materialEditor, "_CameraFadeFar", "_CameraFadeFarCoord", "Camera Fade Far");
            });

            Section("Shadow Caster", () =>
            {
                EditorGUILayout.HelpBox("Shadow Caster is not included in the Built-in first-pass trace.", MessageType.Info);
            });
        }

        private MaterialProperty Property(string name)
        {
            MaterialProperty property;
            return _properties.TryGetValue(name, out property) ? property : null;
        }

        private void Section(string title, System.Action draw)
        {
            bool expanded;
            if (!Foldouts.TryGetValue(title, out expanded)) expanded = true;

            Rect headerRect = EditorGUILayout.GetControlRect(false, EditorGUIUtility.singleLineHeight + 6.0f);
            Color headerColor = new Color(0.14f, 0.14f, 0.14f, 1.0f);
            Color borderColor = new Color(0.34f, 0.34f, 0.34f, 1.0f);
            EditorGUI.DrawRect(headerRect, headerColor);
            EditorGUI.DrawRect(new Rect(headerRect.x, headerRect.y, headerRect.width, 1.0f), borderColor);
            EditorGUI.DrawRect(new Rect(headerRect.x, headerRect.yMax - 1.0f, headerRect.width, 1.0f), borderColor);
            EditorGUI.DrawRect(new Rect(headerRect.x, headerRect.y, 1.0f, headerRect.height), borderColor);
            EditorGUI.DrawRect(new Rect(headerRect.xMax - 1.0f, headerRect.y, 1.0f, headerRect.height), borderColor);

            Rect foldoutRect = headerRect;
            foldoutRect.xMin += 6.0f;
            foldoutRect.xMax -= 4.0f;
            foldoutRect.yMin += 1.0f;
            foldoutRect.yMax -= 1.0f;
            expanded = EditorGUI.Foldout(foldoutRect, expanded, new GUIContent(title), true, SectionFoldoutStyle);
            if (expanded)
            {
                EditorGUILayout.BeginVertical(SectionContentsStyle);
                GUILayout.Space(4.0f);
                draw();
                GUILayout.Space(4.0f);
                EditorGUILayout.EndVertical();
            }
            GUILayout.Space(2.0f);
            Foldouts[title] = expanded;
        }

        private static GUIStyle SectionFoldoutStyle
        {
            get
            {
                if (_sectionFoldoutStyle == null)
                {
                    _sectionFoldoutStyle = new GUIStyle(EditorStyles.foldoutHeader);
                    _sectionFoldoutStyle.fontStyle = FontStyle.Bold;
                    _sectionFoldoutStyle.normal.textColor = Color.white;
                    _sectionFoldoutStyle.onNormal.textColor = Color.white;
                    _sectionFoldoutStyle.hover.textColor = Color.white;
                    _sectionFoldoutStyle.onHover.textColor = Color.white;
                }
                return _sectionFoldoutStyle;
            }
        }

        private static GUIStyle SectionContentsStyle
        {
            get
            {
                if (_sectionContentsStyle == null)
                {
                    _sectionContentsStyle = new GUIStyle(EditorStyles.helpBox);
                    _sectionContentsStyle.padding = new RectOffset(4, 4, 0, 0);
                }
                return _sectionContentsStyle;
            }
        }

        private void Prop(MaterialEditor editor, string propertyName, string label)
        {
            MaterialProperty property = Property(propertyName);
            if (property != null) editor.ShaderProperty(property, label);
        }

        private void Texture(MaterialEditor editor, string propertyName, string label)
        {
            MaterialProperty property = Property(propertyName);
            if (property == null) return;

            float line = EditorGUIUtility.singleLineHeight;
            float spacing = EditorGUIUtility.standardVerticalSpacing;
            float contentsHeight = line * 2.0f;
            float fullHeight = Mathf.Max(contentsHeight + 8.0f, 64.0f) + spacing;
            Rect fullRect = EditorGUILayout.GetControlRect(false, fullHeight);
            Rect innerRect = EditorGUI.IndentedRect(fullRect);
            innerRect.height -= 8.0f;
            innerRect.y += 4.0f;

            Rect textureRect = innerRect;
            textureRect.width = 56.0f;
            textureRect.height = 56.0f;
            textureRect.y += (innerRect.height - textureRect.height) * 0.5f;

            Rect contentsRect = EditorGUI.IndentedRect(fullRect);
            contentsRect.height = contentsHeight;
            contentsRect.y += (fullHeight - contentsHeight) * 0.5f;
            contentsRect.xMin += textureRect.width + 4.0f;

            Rect labelRect = contentsRect;
            labelRect.height = line;
            labelRect.xMax -= fullRect.width - EditorGUIUtility.labelWidth;
            Rect propertyRect = contentsRect;
            propertyRect.height = line;
            propertyRect.xMin += labelRect.width;

            using (new EditorGUI.IndentLevelScope(0))
            {
                EditorGUI.showMixedValue = property.hasMixedValue;
                EditorGUI.BeginChangeCheck();
                Texture texture = (Texture)EditorGUI.ObjectField(textureRect, property.textureValue, typeof(Texture2D), false);
                if (EditorGUI.EndChangeCheck())
                {
                    editor.RegisterPropertyChangeUndo(property.name);
                    property.textureValue = texture;
                }
                EditorGUI.showMixedValue = false;

                GUI.Label(labelRect, "Tiling");
                labelRect.y += line + spacing;
                GUI.Label(labelRect, "Offset");

                Vector4 scaleAndOffset = property.textureScaleAndOffset;
                Vector2 tiling = new Vector2(scaleAndOffset.x, scaleAndOffset.y);
                Vector2 offset = new Vector2(scaleAndOffset.z, scaleAndOffset.w);
                EditorGUI.BeginChangeCheck();
                tiling = EditorGUI.Vector2Field(propertyRect, GUIContent.none, tiling);
                propertyRect.y += line + spacing;
                offset = EditorGUI.Vector2Field(propertyRect, GUIContent.none, offset);
                if (EditorGUI.EndChangeCheck())
                {
                    editor.RegisterPropertyChangeUndo(property.name);
                    property.textureScaleAndOffset = new Vector4(tiling.x, tiling.y, offset.x, offset.y);
                }
            }
        }

        private void Custom(MaterialEditor editor, string propertyName, string coordName, string label)
        {
            MaterialProperty property = Property(propertyName);
            MaterialProperty coordProperty = Property(coordName);
            if (property == null) return;
            if (coordProperty == null)
            {
                editor.ShaderProperty(property, label);
                return;
            }

            Rect row = EditorGUILayout.GetControlRect();
            Rect contentsRect = row;
            contentsRect.xMin += EditorGUIUtility.labelWidth;
            Rect valueRect = row;
            valueRect.xMax -= contentsRect.width * 0.25f;
            Rect coordRect = contentsRect;
            coordRect.width = contentsRect.width * 0.25f - 2.0f;
            coordRect.x += contentsRect.width * 0.75f + 2.0f;
            editor.ShaderProperty(valueRect, property, label);

            CustomCoord coord = (CustomCoord)Mathf.RoundToInt(coordProperty.floatValue);
            if (!System.Enum.IsDefined(typeof(CustomCoord), coord)) coord = CustomCoord.Unused;
            using (new EditorGUI.IndentLevelScope(0))
            {
                EditorGUI.showMixedValue = coordProperty.hasMixedValue;
                EditorGUI.BeginChangeCheck();
                coord = (CustomCoord)EditorGUI.EnumPopup(coordRect, coord);
                if (EditorGUI.EndChangeCheck())
                {
                    editor.RegisterPropertyChangeUndo(coordProperty.name);
                    coordProperty.floatValue = (int)coord;
                }
                EditorGUI.showMixedValue = false;
            }
        }

        private void CoordOnly(MaterialEditor editor, string label, string coordName)
        {
            MaterialProperty coordProperty = Property(coordName);
            if (coordProperty == null) return;
            Rect row = EditorGUILayout.GetControlRect();
            EditorGUI.LabelField(new Rect(row.x, row.y, row.width * 0.70f, row.height), label);
            Rect coordRect = new Rect(row.x + row.width * 0.70f + 2, row.y, row.width * 0.30f - 2, row.height);
            CustomCoord coord = (CustomCoord)Mathf.RoundToInt(coordProperty.floatValue);
            if (!System.Enum.IsDefined(typeof(CustomCoord), coord)) coord = CustomCoord.Unused;
            EditorGUI.BeginChangeCheck();
            coord = (CustomCoord)EditorGUI.EnumPopup(coordRect, coord);
            if (EditorGUI.EndChangeCheck())
            {
                editor.RegisterPropertyChangeUndo(coordProperty.name);
                coordProperty.floatValue = (int)coord;
            }
        }
    }
}
