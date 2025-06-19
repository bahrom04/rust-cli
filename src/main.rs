use clap::Parser;

pub mod config;

fn main() {
    let cli = config::Cli::parse();

    println!("asdasd: {:?}", cli.token);
}
