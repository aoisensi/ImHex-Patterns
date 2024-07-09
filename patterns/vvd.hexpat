#pragma pattern_limit 1048576

#define MAX_NUM_LODS 8
#define MAX_NUM_BONES_PER_VERT 3

struct Vector {
    float x, y, z;
};

struct Vector2D {
    float x, y;
};

struct Tangent {
    float x, y, z, w;
};

struct Header {
    s32 id;
    s32 version;
    s32 checksum;
    s32 numLODs;
    s32 numLODVertexes[MAX_NUM_LODS];
    s32 numFixups;
    s32 fixupTableStart;
    s32 vertexDataStart;
    s32 tangentDataStart;
};

struct Fixup {
    s32 lod;
    s32 sourceVertexID;
    s32 numVertexes;
};

struct BoneWeight {
    float weight[MAX_NUM_BONES_PER_VERT];
    s8 bone[MAX_NUM_BONES_PER_VERT];
    u8 numBones;
};

struct Vertex {
    BoneWeight boneWeights;
    Vector position;
    Vector normal;
    Vector2D texCood;
};

struct VVD {
    Header header;
    Fixup fixups[header.numFixups] @ header.fixupTableStart;
    Vertex verteces[header.numLODVertexes[0]] @ header.vertexDataStart;
    Tangent tangents[header.numLODVertexes[0]] @ header.tangentDataStart;
};

VVD vvd @ 0x00;