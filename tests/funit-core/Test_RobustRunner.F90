!#include "reflection.h"
!-------------------------------------------------------------------------------
! NASA/GSFC, Advanced Software Technology Group
!-------------------------------------------------------------------------------
!  MODULE: Test_RobustRunner
!
!> @brief
!! <BriefDescription>
!!
!! @author
!! Tom Clune,  NASA/GSFC
!!
!! @date
!! 21 Mar 2015
!! 
!! @note <A note here.>
!! <Or starting here...>
!
! REVISION HISTORY:
!
! 21 Mar 2015 - Added the prologue for the compliance with Doxygen. 
!
!-------------------------------------------------------------------------------
module Test_RobustRunner
   use PF_Test
   use PF_RobustRunner
   implicit none
   private

   public :: suite

contains

   function suite()
      use PF_TestSuite, only: TestSuite
      use PF_TestMethod, only: TestMethod
      type (TestSuite) :: suite

      suite = TestSuite('RobustRunner')
!#define ADD(method) call suite%addTest(TestMethod(REFLECT(method)))

      call suite%addTest( &
           &   TestMethod('testRunVariety', &
           &                  testRunVariety))

   end function suite

   subroutine testRunVariety()
      use, intrinsic :: iso_fortran_env
      use robustTestSuite, only: remoteSuite => suite
      use PF_SerialContext, only: THE_SERIAL_CONTEXT
      use PF_TestSuite
      use PF_TestResult
      use PF_Assert
      use PF_TestListener
      use PF_ResultPrinter

      type (RobustRunner) :: runner
      type (TestSuite) :: suite
      type (TestResult) :: result

      integer :: unit

      open(newunit=unit, access='sequential',form='formatted',status='scratch')
      runner = RobustRunner(ResultPrinter(unit), remoteRunCommand='./remote.x')
      suite = remoteSuite()
      result = runner%run(suite, THE_SERIAL_CONTEXT)

      call assertEqual(5, result%runCount(),'runCount()')
      call assertEqual(2, result%errorCount(), 'errorCount()')
      call assertEqual(2, result%failureCount(), 'failureCount()')

      close(unit)

   end subroutine testRunVariety

end module Test_RobustRunner
