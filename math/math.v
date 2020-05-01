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


// Calculate prime number
pub fn gcd(a int, h int) int {
	mut b := a
	mut d := h
	mut temp := 0
	for {
		temp = b % d
		if temp == 0 {
			return d
		}
		b = d
		d = temp
	}
}

// extended Euler's totient function
fn ggt(x int, y int) (int, int, int) {
	mut u := 1
	mut v := 0
	mut s := 0
	mut t := 1
	mut a := x
	mut b := y
	for {
		if b == 0 {
			break
		}
		q := int(a/b)
		mut tmp := a
		a = b
		b = tmp-q*b
		tmp = u
		u = s
		s = tmp-q*s
		tmp = v
		v = t
		t = v-q*t
	}
	return a, u, v
}

fn pow_i(a int, b u32) u64 {
	if b == 0 {
		return 1
	} else if b % 2 == 0 {
		return pow_i(a, b / 2) * pow_i(a, b / 2)
	} else {
		return a * pow_i(a, b / 2) * pow_i(a, b / 2)
	}
}

fn modulo_i(a int, b int) int {
	return (a - b * (a / b))
}