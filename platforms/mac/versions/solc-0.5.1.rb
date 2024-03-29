#------------------------------------------------------------------------------
# solidity.rb
#
# Homebrew formula for solidity.  Homebrew (http://brew.sh/) is
# the de-facto standard package manager for OS X, and this Ruby script
# contains the metadata used to map command-line user settings used
# with the 'brew' command onto build options.
#
# Our documentation for the solidity Homebrew setup is at:
#
# http://solidity.readthedocs.io/en/latest/installing-solidity.html
#
# (c) 2014-2017 solidity contributors.
# https://github.com/ethereum/homebrew-ethereum/blob/8e6c5a613cd822e92cb5a239f3ef7c8576b60d90/solidity.rb
#------------------------------------------------------------------------------

class Solidity < Formula
    desc "The Solidity Contract-Oriented Programming Language"
    homepage "http://solidity.readthedocs.org"
    url "https://github.com/ethereum/solidity/releases/download/v0.5.1/solidity_0.5.1.tar.gz"
    version "0.5.1"
    sha256 "4a58a2f90aea87c1524ea701b5f83f7c42c077770ce19399620c1193cbf4c36c"
  
    depends_on "cmake" => :build
    depends_on "boost" => "c++11"
    # Note: due to a homebrew limitation, ccache will always be detected and cannot be turned off.
    depends_on "ccache" => :build
  
    def install
      system "cmake", ".", *std_cmake_args, "-DTESTS=OFF"
      system "make", "install"
    end
  
    test do
      system "#{bin}/solc", "--version"
    end
  end