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
#------------------------------------------------------------------------------

class Solidity < Formula
  desc "The Solidity Contract-Oriented Programming Language"
  homepage "http://solidity.readthedocs.org"
  url "https://github.com/ethereum/solidity/releases/download/v0.4.19/solidity_0.4.19.tar.gz"
  version "0.4.19"
  sha256 "6525f2cfe498785b3d752b616cb9b5e81222654ec594a27708f45e688bfa56e9"

  depends_on "cmake" => :build
  depends_on "boost@1.60" => "c++11"
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
