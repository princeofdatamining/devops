pull_image() {
    docker pull $3/$2/$1
    docker tag $3/$2/$1 $1
    docker rmi $3/$2/$1
}
pull_image $1 ${2:-library} ${3:-${IMAGE_PREFIX}}
