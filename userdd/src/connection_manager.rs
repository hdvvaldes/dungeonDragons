
use std::{io::Write, net::TcpStream};

const ADDRESS:&str = "127.0.0.1:8080";

struct Actions;

impl Actions {
    
    pub fn send_msg(&self, stream: &mut TcpStream, msg:&String) 
        -> bool{
        let b_msg = msg.as_bytes();
        let bytes = stream.write(b_msg).
            unwrap_or_else(|_| 0);
        bytes !=0
    }

}

pub struct ConnectionManager {
    channel: Option<TcpStream>,
    actions: Actions
}

impl ConnectionManager {
    
    pub fn new() -> Self {
        return Self {
            channel: Option::None,
            actions: Actions
        }
    }

    pub fn connect(&mut self){
        self.channel = TcpStream::connect(&ADDRESS).ok();
    }

    pub fn is_connected(&self) -> bool {
        !self.channel.is_none()
    }

    pub fn send_msg(&mut self, msg: &String) -> bool{
        match self.channel.iter_mut().next() {
            None => return false, 
            Some(x) => 
                self.actions.send_msg(x , msg)
        }

    }

}



