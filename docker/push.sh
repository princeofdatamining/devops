push_image() {
  docker tag $1 $3/$2/$1
  docker push $3/$2/$1
  docker rmi $3/$2/$1
}
push_image $1 ${2:-library} ${3:-${IMAGE_PREFIX}}
