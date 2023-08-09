include env
export

BUILDER_NAME = deploy-builder

ifeq ($(strip $(IMAGE_VERSION)),)
  VER := $(VER)
else
  VER := $(IMAGE_VERSION)
endif

builder_create:
	docker buildx create --name $(BUILDER_NAME) --driver docker-container --use

builder_delete:
	docker buildx rm $(BUILDER_NAME)

build_push_global:
	$(MAKE) builder_create
	docker buildx build \
		--platform linux/amd64,linux/arm64/v8 \
		-f Dockerfile \
		-t $(GLOBAL_IMAGE_NAME):latest \
		-t $(GLOBAL_IMAGE_NAME):$(VER) \
		--push . || true
	$(MAKE) builder_delete

build_push_local:
	$(MAKE) builder_create
	docker buildx build \
		--platform linux/amd64,linux/arm64/v8 \
		-f Dockerfile \
		-t $(LOCAL_IMAGE_NAME):latest \
		-t $(LOCAL_IMAGE_NAME):$(VER) \
		--push . || true
	$(MAKE) builder_delete

build_load_local:
	$(MAKE) builder_create
	docker buildx build \
		-f Dockerfile \
		-t $(LOCAL_IMAGE_NAME):latest \
		-t $(LOCAL_IMAGE_NAME):$(VER) \
		--load . || true
	$(MAKE) builder_delete

build_push: build_push_local build_push_global
