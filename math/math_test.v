import math


fn test_prime(){
	n := math.get_rand_prime(64) or { panic(err) }
	assert math.is_prime(n)
}