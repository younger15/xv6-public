struct userGroup{
	char groupName[96];
	struct userGroup *nextOne;
};
struct userProp{
	char name[96];
	//struct groups *group;
	char group[96];
};

