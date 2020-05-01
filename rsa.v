module main

import math
import crypto.rand

struct PublicKey {
	e u64
	n u64
}

struct PrivateKey {
	d u64
	n u64
}

fn gcd(a int, h int) int {
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

/*
	returns public, private
*/
fn gen_rsa_key(max_len int) (PublicKey, PrivateKey) {
	p := 53//math.get_rand_prime(max_len) or { panic(err) }
	q := 59//math.get_rand_prime(max_len) or { panic(err) }
	n := p*q
	phi := (p-1)*(q-1)
	mut e := 3
	/*for {
		if e < phi {
			if gcd(e, phi) == 1 {
				break
			} else {
				e++
			}
		}
	}*/
	//a, d, b := ggt(e, phi)
	/*println(a)
	println(d)
	println(b)*/
	d := (2 * phi + 1) / e
	return PublicKey{e, n}, PrivateKey{d, n}
}

fn (key PublicKey) encrypt_data(data []byte) []byte {
	mut v := ''
	for x in data {
		v += int(x).str()
	}
	c := (v.u64() ^ key.e) % key.n
	return c.str().bytes()
}

fn (key PrivateKey) decrypt_data(data []byte) []byte {
	mut v := ''
	for x in data {
		v += int(x).str()
	}
	c := (v.u64() ^ key.d) % key.n
	return c.str().bytes()
}

fn main() {
	pub_key, priv_key := gen_rsa_key(512)

	println(pub_key)
	println(priv_key)


	z := 89

	println(modulo_i(pow_i(z, pub_key.e), pub_key.n))
	c := modulo_i(pow_i(z, pub_key.e), pub_key.n)
	o := modulo_i(pow_i(c, priv_key.d), priv_key.n)
	println('Orginal zahl $z wurde zu $c und danach zu $o')
}