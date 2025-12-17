
use std::io;
use std::net::TcpStream;

fn connect_user(name: String) -> TcpStream{
    let mut stream = TcpStream::connect("127.0.0.1:8080")

}


fn main() {
    println!("Welcome to the server for Dungeon and Dragons");
    println!("What is your name?");
    let mut name = String::new();
    io::stdin().read_line(&mut name).expect("Failed to read line");
    println!("Hello {name}");
    
    let mut stream = connect_user(name);
    
    println!("Successful connection");

}









