!-------------------------------------------------------------------------------
! NASA/GSFC Advanced Software Technology Group
!-------------------------------------------------------------------------------
!  MODULE: SerialContext
!
!> @brief
!! <BriefDescription>
!!
!! @author
!! Tom Clune, NASA/GSFC
!!
!! @date
!! 07 Nov 2013
!!
!! @note <A note here.>
!! <Or starting here...>
!
! REVISION HISTORY:
!
! 07 Nov 2013 - Added the prologue for the compliance with Doxygen.
!
!-------------------------------------------------------------------------------
module SerialContext_mod
   use ParallelContext_mod
   implicit none
   private

   public :: SerialContext
   public :: newSerialContext
   public :: THE_SERIAL_CONTEXT

   type, extends(ParallelContext) :: SerialContext
   contains
      procedure :: getNumProcesses
      procedure :: processRank
      procedure :: sum
      procedure :: gatherString
      procedure :: gatherInteger
      procedure :: gatherLogical
      procedure :: allReduce
!TODO - NAG does not yet support FINAL keyword
!!$$      final :: clean
   end type SerialContext

   type (SerialContext), parameter :: THE_SERIAL_CONTEXT = SerialContext()

contains

   function newSerialContext() result(context)
      implicit none
      type (SerialContext) :: context
      context = SerialContext()
   end function newSerialContext

   integer function getNumProcesses(this)
      implicit none
      class (SerialContext),  intent(in) :: this

      getNumProcesses = 1

   end function getNumProcesses

   integer function processRank(this)
      implicit none
      class (SerialContext),  intent(in) :: this
      processRank = 0
   end function processRank

   integer function sum(this, value)
      implicit none
      class (SerialContext), intent(in) :: this
      integer, intent(in) :: value

      sum = value

   end function sum

   subroutine gatherString(this, values, list)
      implicit none
      class (SerialContext), intent(in) :: this
      character(len=*), intent(in) :: values(:)
      character(len=*), intent(out) :: list(:)

      list = values
   end subroutine gatherString

   subroutine gatherInteger(this, values, list)
      implicit none
      class (SerialContext), intent(in) :: this
      integer, intent(in) :: values(:)
      integer, intent(out) :: list(:)

      list = values

   end subroutine gatherInteger

   subroutine gatherLogical(this, values, list)
      implicit none
      class (SerialContext), intent(in) :: this
      logical, intent(in) :: values(:)
      logical, intent(out) :: list(:)

      list = values
   end subroutine gatherLogical

   logical function allReduce(this, q) result(anyQ)
      implicit none
      class (SerialContext), intent(in) :: this
      logical, intent(in) :: q
      anyQ = q
   end function allReduce

   subroutine clean(this)
      implicit none
      type (SerialContext), intent(inout) :: this
   end subroutine clean

end module SerialContext_mod
