class Catch2 < Formula
  desc "Modern, C++-native, header-only, test framework"
  homepage "https://github.com/catchorg/Catch2"
  url "https://github.com/catchorg/Catch2/archive/v2.13.5.tar.gz"
  sha256 "7fee7d643599d10680bfd482799709f14ed282a8b7db82f54ec75ec9af32fa76"
  license "BSL-1.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cc9b4a14e2dba8b4f2271bd376ef08c11d3046f3168f33bac63255cd1c3c73e4"
    sha256 cellar: :any_skip_relocation, big_sur:       "d0edb0bd1f54ca94f52d83b34f01391d977f6e22d9b5edda6969b44f0acae3e2"
    sha256 cellar: :any_skip_relocation, catalina:      "89905994724339d80de88e5fe043c59dda7fee37d608ed44d7c2d38233c44088"
    sha256 cellar: :any_skip_relocation, mojave:        "137c7fd141b94d0c206f0265b3fffbad55cc89c3db52249bd0921a64094576e3"
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-DBUILD_TESTING=OFF", *std_cmake_args
      system "cmake", "--build", ".", "--target", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #define CATCH_CONFIG_MAIN
      #include <catch2/catch.hpp>
      TEST_CASE("Basic", "[catch2]") {
        int x = 1;
        SECTION("Test section 1") {
          x = x + 1;
          REQUIRE(x == 2);
        }
        SECTION("Test section 2") {
          REQUIRE(x == 1);
        }
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-o", "test"
    system "./test"
  end
end
