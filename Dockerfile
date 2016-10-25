
# tweb
#FROM openshift/base-centos7
FROM boyingking/tongweb:6.0

# TODO: Put the maintainer name in the image metadata
MAINTAINER Daniel <yanchong@tongtech.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
ENV BUILDER_VERSION 6.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building tongweb" \
      io.k8s.display-name="builder 6.0" \
      io.openshift.expose-services="8080:http 9060:manager" \
      io.openshift.tags="builder,tongweb,6.0"

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image sets io.openshift.s2i.scripts-url label that way, or update that label
LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i
COPY ./.s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
# RUN chown -R 1001:1001 /opt/app-root
RUN chown -R 1001:root /opt
RUN chown -R 1001:root /tmp
RUN chown -R 1001:root /home/tw6/tongweb6

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080 8043 9060

# TODO: Set the default CMD for the image
CMD ["usage"]
