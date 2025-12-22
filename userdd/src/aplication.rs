use std::io;

use crate::connection_manager::ConnectionManager;

pub struct Aplication {
    c_manager: ConnectionManager,    
}

impl Aplication {
    
    pub fn new() -> Self{
        return Self{ 
            c_manager: ConnectionManager::new()
        }
    }

    pub fn is_running(&self) -> bool{
        return self.c_manager.is_connected();
    }

    pub fn start(&mut self) {
        println!("Welcome to the server for Dungeon and Dragons");
        println!("What is your name?");
        let mut name = String::new();
        io::stdin()
            .read_line(&mut name)
            .expect("Failed to read line");
        println!("Hello {name}");
        self.c_manager.connect();
    }

    pub fn run(&mut self) {
        let mut msg = String::new();
        io::stdin()
            .read_line(&mut msg)
            .expect("Failed to read line");
        self.c_manager.
            send_msg(&msg);
    }

    pub fn close(&self) {

    }

}
