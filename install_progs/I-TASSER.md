# Install programs 

# I-TASSER
# Install from https://zhanglab.ccmb.med.umich.edu/I-TASSER/addition/
# Also need to download GO::Parser https://fastapi.metacpan.org/source/CMUNGALL/go-perl-0.15/INSTALL.html

perl -MCPAN -e shell
install GO::Parser

# Installed a dependancy for cpan called libxslt. Git cloned from  https://gitlab.gnome.org/GNOME/libxslt/

./compile --prefix=/home/hulinm/local/src/libxslt
make
make install

# Need to patch perl to get this to work as problem with new libxslt versions 

patch go-perl.patch





