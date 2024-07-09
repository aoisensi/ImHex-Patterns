struct Vector {
    float x, y, z;
};

struct BodyPart {
    s32 nameOffset;
    char name[] @ $ - 4 + nameOffset;
    s32 modelCount;
    s32 _;
    s32 modelOffset;
};

struct AnimDesc {
    s32 basePtr;
    s32 nameOffset;
    char name[] @ $ - 8 + nameOffset;
    float fps;
    u32 flags;
    padding[24];
    s32 numFrames;
    s32 numMovement;
    s32 movementOffset;
    s32 animBlock;
    s32 animIndex;
    s32 numIKRule;
    s32 ikRuleIndex;
    s32 animBlockIKRuleIndex;
    s32 numLocalHierarchy;
    s32 localHierarchyIndex;
    s32 sectionIndex;
    s32 sectionFrames;
    s16 zeroFrameSpan;
    s16 zeroFrameCount;
    s32 zeroFrameIndex;
    float zeroFramesTallTime;
};

struct SeqDesc {
    s32 basePtr;
    s32 labelOffset;
    char label[] @ $ - 8 + labelOffset;
    s32 activityNameOffset;
    u32 flags;
    s32 activity;
    s32 actWeight;
    s32 numEvents;
    s32 eventIndex;
    Vector bbMin;
    Vector bbMax;
    s32 numBlends;
    s32 animIndexIndex;
    s32 movementIndex;
    s32 gorupSize[2];
    s32 paramIndex[2];
    float paramStart[2];
    float paramEnd[2];
    s32 paramParent;
    float fadeInTime;
    float fadeOutTime;
    s32 localEntryNode;
    s32 localExitNode;
    u32 nodeFlags;
    float entryPhase;
    float exitPhase;
    float lastFrame;
    s32 nextSeq;
    s32 pose;
    s32 numIKRules;
    s32 numAutoLayers;
    s32 autoLayerIndex;
    s32 weightListIndex;
    s32 poseKeyIndex;
    s32 numIKLocks;
    s32 ikLockIndex;
    s32 keyvalueIndex;
    s32 keyvalueSize;
    s32 cyclePoseIndex;
    padding[28];
};

struct Main {
// should fix to camelCase
    s32        bone_count;
    s32        bone_offset;
 
    s32        bonecontroller_count;
    s32        bonecontroller_offset;
 
    s32        hitbox_count;
    s32        hitbox_offset;
 
    s32        localAnimCount;
    s32        localAnimOffset;
 
    s32        localSeqCount;
    s32        localSeqOffset;
 
    s32        activitylistversion;
    s32        eventsindexed;
 
    s32        texture_count;
    s32        texture_offset;
 
    s32        texturedir_count;
    s32        texturedir_offset;
 
    s32        skinreference_count;
    s32        skinrfamily_count;
    s32        skinreference_index;
 
    s32        bodypart_count;
    s32        bodypart_offset;
 
    s32        ikchain_count;
};

struct Header {
    s32 id;
    s32 version;
    s32 checksum;
    char name[64];
    s32 dataLength;
    Vector eyePosition;
    Vector illumPosition;
    Vector hullBBMin;
    Vector hullBBMax;
    Vector viewBBMin;
    Vector viewBBMax;
    u32 flags;
};

struct MDL {
    Header header;
    Main main;
    AnimDesc animDescs[main.localAnimCount] @ main.localAnimOffset;
    SeqDesc seqDescs[main.localSeqCount] @ main.localSeqOffset;
    BodyPart bodyParts[main.bodypart_count] @ main.bodypart_offset;
};

MDL mdl @ 0x00;

