DIRS=ergo88-receiver-basic/custom/armgcc ergo88-keyboard-basic/custom/armgcc

all::
	make -C ergo88-receiver-basic/custom/armgcc; \
	make -C ergo88-keyboard-basic/custom/armgcc keyboard_side=left; \
	make -C ergo88-keyboard-basic/custom/armgcc keyboard_side=right;

clean::
	make -C ergo88-receiver-basic/custom/armgcc clean; \
	make -C ergo88-keyboard-basic/custom/armgcc clean; \
	make -C ergo88-keyboard-basic/custom/armgcc clean;
