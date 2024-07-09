#pragma pattern_limit 1048576

#define MAX_NUM_LODS 8
#define MAX_NUM_BONES_PER_VERT 3

struct Header {
    s32 version;
    s32 vertCacheSize;
    u16 maxBonesPerStrip;
    u16 maxBonesPerTri;
    s32 maxBonesPerVert;
    s32 checksum;
    s32 numLODs;
    s32 materialReplacementListOffset;
};

struct Strip {
    s32 numIndices;
    s32 indexOffset;
    s32 numVerts;
    s32 vertOffset;
    s16 numBones;
    u8 flags;
    s32 numBoneStateChanges;
    s32 boneStateChangeOffset;
};

struct Vertex {
    u8 boneWeightIndex[MAX_NUM_BONES_PER_VERT];
    u8 numBones;
    u16 origMeshVertID;
    s16 boneID[MAX_NUM_BONES_PER_VERT];
};

struct StripGroup {
    s32 numVerts;
    s32 vertOffset;
    s32 numIndices;
    s32 indexOffset;
    s32 numStrips;
    s32 stripOffset;
    u8 flags;
    
    Vertex vertexes[numVerts] @ $ - 25 + vertOffset;
    u16 indices[numIndices] @ $ - 25 + indexOffset;
    Strip strips[numStrips] @ $ - 25 + stripOffset;
};

struct Mesh {
    s32 numStripGroups;
    s32 stripGroupOffset;
    u8 flags;
    StripGroup stripGroups[numStripGroups] @ $ - 9 + stripGroupOffset;
};

struct ModelLOD {
    s32 numMeshes;
    s32 meshOffset;
    float switchPoint;
    Mesh meshes[numMeshes] @ $ - 12 + meshOffset;
};

struct Model {
    s32 numLODs;
    s32 lodOffset;
    ModelLOD modelLODs[numLODs] @ $ - 8 + lodOffset;
};

struct BodyPart {
    s32 numModels;
    s32 modelOffset;
    Model models[numModels] @ $ - 8 + modelOffset;
};

struct VTX {
    Header header;
    s32 numBodyParts;
    s32 bodyPartOffset;
    BodyPart bodyParts[numBodyParts] @ bodyPartOffset;
};

VTX vtx @0x0;
