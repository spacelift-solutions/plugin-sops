FROM public.ecr.aws/spacelift/runner-terraform:latest

WORKDIR /tmp

# Temporarily elevating permissions
USER root

#RUN apt install sops
RUN apk add --no-cache sops

# Back to the restricted "spacelift" user
USER spacelift
