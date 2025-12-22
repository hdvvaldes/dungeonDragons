use crate::aplication::Aplication;

mod aplication;
mod connection_manager;

fn main() {
    
    let mut app = Aplication::new();
    app.start();
    while app.is_running() {
        app.run();
    }
    app.close();

}









