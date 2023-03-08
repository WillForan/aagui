(ql:quickload :py4cl2)
(ql:quickload :april)
(py4cl2:defpymodule "nibabel" nil :lisp-package "NIB")
(py4cl2:defpymodule "numpy" nil :lisp-package "NP")
(defun read-nifti (fname)
  (let ((mybrain (nib:load :filename fname)))
    ;; # same as (np:array img :order "C")
    (np:ascontiguousarray (py4cl2:pyslot-value mybrain 'dataobj))))


;; (setq img (py4cl2:pyslot-value mybrain 'dataobj))
;; #S(PY4CL2::PYTHON-OBJECT
   ;; :TYPE "<class 'nibabel.arrayproxy.ArrayProxy'>"
   ;; :HANDLE 34)

;; (np:array img)
;; ;; Reading arrays in Fortran order is not yet supported.
;; 
;; (py4cl2:pyhelp mybrain) ; Nifti1Pair
;; (setq h (py4cl2:chain* mybrain '(get-fdata))) ; slow, errors
;; (py4cl2:pymethod mybrain 'get-fdata); fast, errors
;; Reading arrays in Fortran order is not yet supported.

;; wrap to return nil to avoid breaking repl
(defparameter *imgdata* nil "store nifti image data")
(progn 
  (setq *imgdata* (read-nifti "/mnt/storage/mybrain/mybrain_2018-10-31.nii.gz"))
  nil)
;; someimes kills sly?!
;; alt: (load "nibabel.lisp") works okay
;; Process sly-pty-1-2 killed
; Lisp connection closed unexpectedly: connection broken by remote peer

(print  (april:april-c "{⍴⍵}" *imgdata*))


(ql:quickload :sdl2)
