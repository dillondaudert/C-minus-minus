SRCS = add.cm add.float.cm and.cm and.float.cm arith.cm array.cm array.float.cm bubble.cm bubble.float.cm call.cm div.cm div.float.cm dynamic.cm eq.cm expr.float.cm farray.cm f_noparams.cm gcd.cm gt.cm hello.cm if1.cm if.cm if.float.cm io.cm io.float.cm log.cm lt.cm mul.cm mul.float.cm newdyn.cm not.cm or.cm or.float.cm param.cm p_noparams.cm recurs.cm sub.cm sub.float.cm test.cm while2.cm while2.float.cm while3.cm while_array.cm while.cm while.float.cm

ASMS = $(addsuffix .s,$(basename $(SRCS)))

TARGETS = $(basename $(SRCS))

IAS = ~/bin/ias
CMC = ../cmc

target: $(ASMS)

%: %.s
	$(IAS) $<

%.s: %.cm $(CMC)
	$(CMC) $<

clean: 
	$(RM) $(ASMS) $(TARGETS)
