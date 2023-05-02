git clone https://github.com/axiomatic-systems/Bento4/
cd Bento4
pwd
#alias mp4dash='bash "$(pwd)/Source/Python/wrappers/mp4dash"'
mkdir cmakebuild
cd cmakebuild
cmake -DCMAKE_BUILD_TYPE=Release ..
make
sudo make install
