all: new

new:
	@read -p "Title: " title; \
	read -p "Abstract: " abstract; \
	url=$$(echo "$$title" | gsed \
		-e "s/\(.*\)/\L\1/" \
		-e "s/\&/and/g" \
		-e "s/\s\+/-/g" \
		-e "s/[^a-z0-9-]//g"); \
	out="$$url.md"; \
	echo "\`\`\`metadata" >> "$$out"; \
	echo "title: $$title" >> "$$out"; \
	echo "date: $$(date +'%F %T %z')" >> "$$out"; \
	echo "abstract: $$abstract" >> "$$out"; \
	echo "\`\`\`" >> "$$out"; \
	gecho -e "\n" >> "$$out"; \
	vim -c '+norm G' '+star' "$$out"
