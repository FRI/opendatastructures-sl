
all:
	(cd java ; make)
	(cd latex ; make)

clean:
	(cd java ; make clean)
	(cd latex ; make clean)

tarballs:
	tar czvf ods-sl-javasrc.tgz java/ods/
	tar czvf ods-sl-cppsrc.tgz cpp/

install: all tarballs
	(cd latex ; make install)
#	scp ods-java.tgz ods-cpp.tgz morin@cg.scs.carleton.ca:public_html/ods/

install-pdf: all tarballs
	(cd latex ; make install-pdf)
#	scp ods-java.tgz ods-cpp.tgz morin@cg.scs.carleton.ca:public_html/ods/

