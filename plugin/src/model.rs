use serde::Deserialize;
use std::collections::HashMap;

#[derive(Deserialize, Debug, Clone, PartialEq)]
#[serde(rename_all = "kebab-case")]
pub struct Config {
    pub source: String,
    pub msg_id: String,
    pub args: HashMap<String, Value>,
    pub lang: String,
}

#[derive(Deserialize, Debug, Clone, PartialEq)]
#[serde(untagged, rename_all = "kebab-case")]
pub enum Value {
    String(String),
    Number(i64),
    Float(f64),
}
