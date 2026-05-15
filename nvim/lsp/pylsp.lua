return {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'E303'},
          maxLineLength = 160
        }
      }
    }
  },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
}
