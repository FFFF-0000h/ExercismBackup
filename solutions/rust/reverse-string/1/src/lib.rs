// For the bonus task with grapheme clusters
#[cfg(feature = "grapheme")]
use unicode_segmentation::UnicodeSegmentation;

pub fn reverse(input: &str) -> String {
    // Check if we're running with grapheme feature
    #[cfg(feature = "grapheme")]
    {
        // Bonus: Use grapheme segmentation for proper character reversal
        input.graphemes(true).rev().collect()
    }
    
    #[cfg(not(feature = "grapheme"))]
    {
        // Standard implementation for regular tests
        input.chars().rev().collect()
    }
}