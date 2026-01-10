// @ts-check

/**
 * Removes duplicate tracks from a playlist.
 * Uses Set for O(1) lookups and O(n) deduplication.
 *
 * @param {string[]} playlist
 * @returns {string[]} new playlist with unique entries
 */
export function removeDuplicates(playlist) {
  // Set automatically removes duplicates, then convert back to array
  return [...new Set(playlist)];
}

/**
 * Checks whether a playlist includes a track.
 * Uses Set for O(1) lookup instead of Array.includes() which is O(n).
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {boolean} whether the track is in the playlist
 */
export function hasTrack(playlist, track) {
  // Convert to Set for efficient lookup
  const playlistSet = new Set(playlist);
  return playlistSet.has(track);
}

/**
 * Adds a track to a playlist.
 * Uses Set to avoid duplicates efficiently.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {string[]} new playlist
 */
export function addTrack(playlist, track) {
  const playlistSet = new Set(playlist);
  playlistSet.add(track);
  return [...playlistSet];
}

/**
 * Deletes a track from a playlist.
 * Uses Set for efficient deletion.
 *
 * @param {string[]} playlist
 * @param {string} track
 * @returns {string[]} new playlist
 */
export function deleteTrack(playlist, track) {
  const playlistSet = new Set(playlist);
  playlistSet.delete(track);
  return [...playlistSet];
}

/**
 * Lists the unique artists in a playlist.
 * Extracts artist from "SONG - ARTIST" format.
 *
 * @param {string[]} playlist
 * @returns {string[]} list of artists
 */
export function listArtists(playlist) {
  const artists = new Set();
  
  for (const track of playlist) {
    // Extract artist: everything after " - "
    const artist = track.split(' - ')[1];
    if (artist) {
      artists.add(artist);
    }
  }
  
  return [...artists];
}