module math

import crypto.rand

pub fn get_rand_prime(max_len int) ?u64 {
	if max_len < 5 {
		return error('max length is too small. Must be larger than 5')
	}
	for {
		n := rand.int_u64(max_len) or { return error(err) }
		if is_prime(n){
			return n
		}
	}
}

pub fn is_prime(n u64) bool {
	if n < 2 {
		return false
	}

	for i := 2; i <= n / 2 ; i += 1 {
		if n % i == 0 {
			return false
		}
	}
	return true
}