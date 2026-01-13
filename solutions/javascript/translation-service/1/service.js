/// <reference path="./global.d.ts" />
// @ts-check
//
// The lines above enable type checking for this file. Various IDEs interpret
// the @ts-check and reference directives. Together, they give you helpful
// autocompletion when implementing this exercise. You don't need to understand
// them in order to use it.
//
// In your own projects, files, and code, you can play with @ts-check as well.

export class TranslationService {
  /**
   * Creates a new service
   * @param {ExternalApi} api the original api
   */
  constructor(api) {
    this.api = api;
  }

  /**
   * Attempts to retrieve the translation for the given text.
   *
   * - Returns whichever translation can be retrieved, regardless the quality
   * - Forwards any error from the translation api
   *
   * @param {string} text
   * @returns {Promise<string>}
   */
  free(text) {
    return this.api.fetch(text)
      .then(translation => translation.translation);
  }

  /**
   * Batch translates the given texts using the free service.
   *
   * - Resolves all the translations (in the same order), if they all succeed
   * - Rejects with the first error that is encountered
   * - Rejects with a BatchIsEmpty error if no texts are given
   *
   * @param {string[]} texts
   * @returns {Promise<string[]>}
   */
  batch(texts) {
    if (texts.length === 0) {
      return Promise.reject(new BatchIsEmpty());
    }
    
    // Create an array of promises using the free method
    const promises = texts.map(text => this.free(text));
    
    // Use Promise.all to wait for all promises to resolve
    // It will reject with the first error encountered
    return Promise.all(promises);
  }

  /**
   * Requests the service for some text to be translated.
   *
   * Note: the request service is flaky, and it may take up to three times for
   *       it to accept the request.
   *
   * @param {string} text
   * @returns {Promise<void>}
   */
  request(text) {
    return new Promise((resolve, reject) => {
      let attempts = 0;
      const maxAttempts = 3;
      
      const tryRequest = () => {
        attempts++;
        this.api.request(text, (error) => {
          if (!error) {
            resolve();
          } else if (attempts < maxAttempts) {
            // Retry if we have attempts left
            tryRequest();
          } else {
            // Reject with the last error if we run out of attempts
            reject(error);
          }
        });
      };
      
      tryRequest();
    });
  }

  /**
   * Retrieves the translation for the given text
   *
   * - Rejects with an error if the quality can not be met
   * - Requests a translation if the translation is not available, then retries
   *
   * @param {string} text
   * @param {number} minimumQuality
   * @returns {Promise<string>}
   */
  premium(text, minimumQuality) {
    return this.api.fetch(text)
      .then(translation => {
        // Check if quality meets threshold
        if (translation.quality < minimumQuality) {
          throw new QualityThresholdNotMet(text);
        }
        return translation.translation;
      })
      .catch(error => {
        // Check if the error is a NotAvailable error by checking the error name/message
        // NotAvailable errors have a specific message pattern
        if (error.name === 'NotAvailable' || 
            (error.message && error.message.includes('not been translated yet'))) {
          // Request the translation and then fetch it again
          return this.request(text)
            .then(() => this.api.fetch(text))
            .then(translation => {
              if (translation.quality < minimumQuality) {
                throw new QualityThresholdNotMet(text);
              }
              return translation.translation;
            })
            .catch(requestError => {
              // If request or second fetch fails, propagate the error
              throw requestError;
            });
        }
        
        // Check if it's a QualityThresholdNotMet error
        if (error instanceof QualityThresholdNotMet) {
          throw error;
        }
        
        // For any other error (Untranslatable, AbusiveClientError, etc.), propagate it
        throw error;
      });
  }
}

/**
 * This error is used to indicate a translation was found, but its quality does
 * not meet a certain threshold. Do not change the name of this error.
 */
export class QualityThresholdNotMet extends Error {
  /**
   * @param {string} text
   */
  constructor(text) {
    super(
      `
The translation of ${text} does not meet the requested quality threshold.
    `.trim(),
    );

    this.text = text;
  }
}

/**
 * This error is used to indicate the batch service was called without any
 * texts to translate (it was empty). Do not change the name of this error.
 */
export class BatchIsEmpty extends Error {
  constructor() {
    super(
      `
Requested a batch translation, but there are no texts in the batch.
    `.trim(),
    );
  }
}