$nyquist plug-in
$version 4
$type process
$preview linear
$name (_ "DolphinAttack Filter")
$manpage "DolphinAttack_Filter"
$debugbutton disabled
$action (_ "Performing DolphinAttack Filter...")
$author (_ "Team J4")
$release 3.0.5
$copyright (_ "Released under terms of the GNU General Public License version 2")

$control text "Demodulate = Find hidden high frequency audio"
$control text "Modulate = Change the frequency of your audio file to embed in another"
$control text "Sanitize = Remove hidden high frequency audio"

;; prompt if user wants to sanitize audio or find the hidden message or increase the frequency of their message
$control choice "What to do" choice "Demodulate, Modulate, Sanitize"

$control text "Carrier Frequency not required for sanitization."

;; Frequncy of the dolphin attack
$control carrierFreq "Carrier Frequency" float-text "Hz" 20000 0 nil

(cond
	(
		(= choice 0)
		(
			if (< carrierFreq 0.1)
					(_ "Carrier Frequency must be at least 0.1 Hz.")
			(let ((demod (mult *track* (hzosc carrierFreq))))
				(lowpass8 demod 10000))
		)
	)
	(
		(= choice 1)
		(
			if (< carrierFreq 0.1)
					(_ "Carrier Frequency must be at least 0.1 Hz.")
			(mult *track* (hzosc carrierFreq))
		)
	)
	(
		(= choice 2) (lowpass8 (lowpass8 *track* 20000) 20000)
	)
)

;; Printing variables (format nil (_ "~a") <variable name>)
  
