use yara::{Compiler, Rules};
use log::{info, warn};

pub struct YaraScanner {
    rules: Rules,
}

impl YaraScanner {
    pub fn new(rule_path: &str) -> Result<Self, yara::Error> {
        info!("Compiling YARA ruleset from: {}", rule_path);
        let compiler = Compiler::new()?;
        let compiler = compiler.add_rules_file(rule_path)?;
        let rules = compiler.compile_rules()?;
        
        Ok(Self { rules })
    }

    pub fn scan_buffer(&self, data: &[u8]) {
        let results = self.rules.scan_mem(data, 10).unwrap();
        if !results.is_empty() {
            for rule in results {
                warn!("YARA Signature Match Triggered: {}", rule.identifier);
            }
        }
    }
}
