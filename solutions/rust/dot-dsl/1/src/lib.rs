pub mod graph {
    use graph_items::{edge::Edge, node::Node};
    use std::collections::HashMap;

    pub mod graph_items {

        pub mod edge {
            use std::collections::HashMap;

            #[derive(Debug, Clone, PartialEq)]
            pub struct Edge {
                pub start: String,
                pub end: String,
                pub attrs: HashMap<String, String>,
            }

            impl Edge {
                pub fn new(start: &str, end: &str) -> Self {
                    Edge {
                        start: start.to_string(),
                        end: end.to_string(),
                        attrs: HashMap::new(),
                    }
                }

                pub fn with_attrs(self, attrs: &[(&str, &str)]) -> Self {
                    let mut edge = self;
                    let attrs_owned: HashMap<String, String> = attrs
                        .iter()
                        .map(|(k, v)| (k.to_string(), v.to_string()))
                        .collect();

                    edge.attrs.extend(attrs_owned);
                    edge
                }

                pub fn attr(&self, key: &str) -> Option<&str> {
                    self.attrs.get(key).map(|x| x.as_str())
                }
            }
        }

        pub mod node {
            use std::collections::HashMap;

            #[derive(Debug, Clone, PartialEq)]
            pub struct Node {
                pub value: String,
                pub attrs: HashMap<String, String>,
            }

            impl Node {
                pub fn new(value: &str) -> Self {
                    Node {
                        value: value.to_string(),
                        attrs: HashMap::new(),
                    }
                }

                pub fn with_attrs(self, attrs: &[(&str, &str)]) -> Self {
                    let mut node = self;
                    let attrs_owned: HashMap<String, String> = attrs
                        .iter()
                        .map(|(k, v)| (k.to_string(), v.to_string()))
                        .collect();

                    node.attrs.extend(attrs_owned);
                    node
                }

                pub fn attr(&self, key: &str) -> Option<&str> {
                    self.attrs.get(key).map(|x| x.as_str())
                }
            }
        }
    }

    pub struct Graph {
        pub nodes: Vec<Node>,
        pub edges: Vec<Edge>,
        pub attrs: HashMap<String, String>,
    }

    impl Graph {
        pub fn new() -> Self {
            Self {
                nodes: Vec::new(),
                edges: Vec::new(),
                attrs: HashMap::new(),
            }
        }

        pub fn with_nodes(self, nodes: &[Node]) -> Self {
            let mut graph = self;
            graph.nodes = nodes.to_owned();
            graph
        }

        pub fn with_edges(self, edges: &[Edge]) -> Self {
            let mut graph = self;
            graph.edges = edges.to_owned();
            graph
        }

        pub fn with_attrs(self, attrs: &[(&str, &str)]) -> Self {
            let mut graph = self;
            let attrs_owned: HashMap<String, String> = attrs
                .iter()
                .map(|(k, v)| (k.to_string(), v.to_string()))
                .collect();

            graph.attrs.extend(attrs_owned);
            graph
        }

        pub fn node(&self, target: &str) -> Option<Node> {
            self.nodes.clone().into_iter().find(|n| n.value == target)
        }
    }
}