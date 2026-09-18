<?php


/**
 * The interface that must be implemented by all observers of an
 * Observable object.
 */
class  KF_Util_Observer {
  /**
   * Invoked automatically by an observed object when it changes.
   * 
   * @param   o   The observed object (an instance of Observable).
   * @param   infoObj   An arbitrary data object sent by 
   *                    the observed object.
   */
	function update(&$o, &$infoObj)
	{

	}

}

?>