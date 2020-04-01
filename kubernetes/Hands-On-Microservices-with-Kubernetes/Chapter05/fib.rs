fn main() {
    let mut a: u64 = 0;
    let mut b: u64 = 1;
    println!("{}", a);
    while b <= 10000000000000000000 {
        println!("{}", b);
        b = a + b;
        a = b - a;
    }
}
