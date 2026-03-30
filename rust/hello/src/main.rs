fn greeting() -> &'static str {
    "Hello, Vibe-Vibe"
}

fn main() {
    println!("{}", greeting());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_greeting() {
        assert_eq!(greeting(), "Hello, Vibe-Vibe");
    }
}
