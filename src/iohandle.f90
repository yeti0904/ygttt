module IOHandle
    ! modules
    use :: M_ncurses

    ! variables
    implicit none

    ! functions
    contains
    subroutine IOHandle_Init()
        integer    :: rc
        logical(1) :: true = .true.
        stdscr = initscr()
        rc     = raw()
        rc     = keypad(stdscr, true)
        rc     = curs_set(0)
    end subroutine IOHandle_Init

    subroutine IOHandle_Quit()
        integer :: rc
        rc = endwin()
    end subroutine IOHandle_Quit
end module IOHandle