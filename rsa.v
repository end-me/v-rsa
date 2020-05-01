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

/*
	returns public, private
*/
fn gen_rsa_key(max_len int) (PublicKey, PrivateKey) {
	p := math.get_rand_prime(max_len) or { panic(err) }
	q := math.get_rand_prime(max_len) or { panic(err) }
	n := p*q
	o := (p-1)*(q-1)
	mut e := u64(0)
	for {
		l := rand.int_u64(o) or { panic(err) }
		if l > 1 && l < o {
			e = l
			break
		}
	}
	k := rand.int_u64(max_len) or { panic(err) }
	d := (k*o + 1) / e
		
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
	a := 50
	println(a)
	encrypted := (a^pub_key.e) % pub_key.n
	println(encrypted)
	decrypted := (encrypted^priv_key.d) % priv_key.n
	println(decrypted)
}