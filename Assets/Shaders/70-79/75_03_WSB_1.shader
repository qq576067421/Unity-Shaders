﻿// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/70-79/75_03_WSB_1"
{
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            struct vertexInput
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float4 tangent : TANGENT;
            };
            
            struct vertexOuput
            {
                float4 pos : SV_POSITION;
                float4 normalWorld : TEXCOORD0;
                float4 tangentWorld : TEXCOORD1;
                float4 binormalWorld : TEXCOORD2;
            };
            
            vertexOuput vert(vertexInput v)
            {
                vertexOuput o;
                UNITY_INITIALIZE_OUTPUT(vertexOuput, o);
                
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normalWorld = normalize(mul(normalize(v.normal), unity_WorldToObject));
                o.tangentWorld = normalize(mul(v.tangent, unity_ObjectToWorld));
                o.binormalWorld = float4(normalize(cross(o.normalWorld, o.tangentWorld) * o.tangentWorld.w), 0);
                
                return o;
            }
            
            float4 frag(vertexOuput i) : COLOR
            {
                return i.binormalWorld;
            }
            ENDCG
        }
    }
}   