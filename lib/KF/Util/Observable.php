<?php
//import util.Observer;
/**
 * A Java-style Observable class used to represent the "subject"
 * of the Observer design pattern. Observers must implement the Observer
 * interface, and register to observe the subject via addObserver().
 */
class KF_Util_Observable {
  // A flag indicating whether this object has changed.
	var $changed = false;
  // A list of observers.
	var $observers = Array();

  /**
   * Constructor function.
   */
	function  KF_Util_Observable() 
	{
	
	}

  /**
   * Adds an observer to the list of observers.
   * @param   o   The observer to be added.
   */
	function addObserver(&$o) 
	{
		// Can't add a null observer.
		if ($o == null) {
		  return false;
		}

		// Don't add an observer more than once.
		for ($i = 0; $i < count($this->observers); $i++) {
			if ($this->observers[$i] == $o) {
			// The observer is already observing, so quit.
			return false;
			}
		}

		// Put the observer into the list.
		$this->observers[] = &$o;
		return true;
	}

  /**
   * Removes an observer from the list of observers.
   *
   * @param   o   The observer to remove.
   */
  function removeObserver(&$o){
    // Find and remove the observer.
     for ($i = 0; $i < count($this->observers); $i++) {
      if ($this->observers[i] == $o) {
        array_splice($this->observers, $i, 1);
        return true;
      }
    }
    return false;
  }

  /**
   * Tell all observers that the subject has changed.
   *
   * @param   infoObj   An object containing arbitrary data 
   *                    to pass to observers.
   */
	function notifyObservers(&$infoObj) {
   
    // If the object hasn't changed, don't bother notifying observers.
    if (!$this->changed) {
      return;
    }

    // This change has been processed, so unset the "changed" flag.
    $this->clearChanged();

    // Invoke update() on all observers.
    for ($i = count($this->observers) - 1; $i >= 0; $i--) {
		$tmp = &$this->observers[$i];
		$tmp->update($this, $infoObj);
    }
  }

  /**
   * Removes all observers from the observer list.
   */
  function clearObservers() {
	$this->observers =  Array();
  }

  /**
   * Indicates that the subject has changed.
   */
  function setChanged() {
    $this->changed = true;
  }

  /**
   * Indicates that the subject has either not changed or
   * has notified its observers of the most recent change.
   */
  function clearChanged() {
    $this->changed = false;
  }

  /**
   * Checks if the subject has changed.
   *
   * @return   true if the subject has changed, as determined by setChanged().
   */
  function hasChanged() {
    return $this->changed;
  }

  /**
   * Returns the number of observers in the observer list.
   *
   * @return   An integer: the number of observers for this subject.
   */
  function countObservers() {
    return count($this->observers);
  }
}
?>