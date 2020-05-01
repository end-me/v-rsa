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
	phi := (p-1)*(q-1)
	mut e := 3
	for {
		if e < phi {
			if math.gcd(e, phi) == 1 {
				break
			} else {
				e++
			}
		}
	}
	/*a, d, b := math.ggt(e, phi)
	println(a)
	println(d)
	println(b)*/
	mut d := u64(0)
	for i := 0; i < phi; i++ {
		if i * e % phi == 1 {
			d = i
		}
	}
	return PublicKey{e, n}, PrivateKey{d, n}
}

fn (key PublicKey) encrypt(data u64) u64 {
	c := (data ^ key.e) % key.n
	return c
}


fn (key PrivateKey) decrypt(data u64) u64 {
	c := (data ^ key.d) % key.n
	return c
}

fn main() {
	pub_key, priv_key := gen_rsa_key(1024)

	/*pub_key = PublicKey{
		n: 3233,

	}*/

	println(pub_key)
	println(priv_key)


	z := 99

	/*println(math.modulo_i(math.pow_i(z, pub_key.e), pub_key.n))*/
	//c := math.modulo_i(math.pow_i(z, pub_key.e), pub_key.n)
	//o := math.modulo_i(math.pow_i(c, priv_key.d), priv_key.n)
	c := pub_key.encrypt(z)
	o := priv_key.decrypt(z)
	println('Orginal zahl $z wurde zu $c und danach zu $o')
}