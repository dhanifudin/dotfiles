if exists('g:plugs["deoplete-padawan"]')
  command! PadawanStart call deoplete#sources#padawan#StartServer()
  command! PadawanStop call deoplete#sources#padawan#StopServer()
  command! PadawanRestart call deoplete#sources#padawan#RestartServer()
  command! PadawanInstall call deoplete#sources#padawan#InstallServer()
  command! PadawanUpdate call deoplete#sources#padawan#UpdatePadawan()
  command! -bang PadawanGenerate call deoplete#sources#padawan#Generate(<bang>0)
endif
