program ygttt
    ! modules
    use                   :: M_ncurses
    use                   :: IOHandle
    use                   :: Board
    use                   :: Types
    use, intrinsic        :: iso_c_binding

    ! variables
    implicit none
    integer               :: rc
    type(Vec2_t)          :: cursor
    integer, dimension(2) :: boardSize
    integer               :: turn
    logical               :: run = .true.
    integer               :: input
    integer               :: i, j ! iterator
    logical               :: gameOver = .false.

    call IOHandle_Init()
    call Board_Init()

    cursor%x  = 1
    cursor%y  = 1
    turn      = Turn_X
    boardSize = shape(boardArray)

    do while (run)
        call Render
        
        input = getch()
        select case (input)
            case (ichar('q', 2))
                run = .false.
            case (KEY_RIGHT)
                if (cursor%x /= boardSize(1)) then
                    cursor%x = cursor%x + 1
                end if
            case (KEY_LEFT)
                if (cursor%x /= 1) then
                    cursor%x = cursor%x - 1
                end if
            case (KEY_DOWN)
                if (cursor%y /= boardSize(2)) then
                    cursor%y = cursor%y + 1
                end if
            case (KEY_UP)
                if (cursor%y /= 1) then
                    cursor%y = cursor%y - 1
                end if
            case (ichar(' ', 2))
                if (boardArray(cursor%y, cursor%x) == ' ') then
                    select case (turn)
                        case (Turn_X)
                            boardArray(cursor%y, cursor%x) = 'X'
                            gameOver = Board_Line('X')
                            if (.not. gameOver) then
                                turn = Turn_O
                            end if
                        case (Turn_O)
                            boardArray(cursor%y, cursor%x) = 'O'
                            gameOver = Board_Line('O')
                            if (.not. gameOver) then
                                turn = Turn_X
                            end if
                    end select
                end if
        end select
    end do

    call IOHandle_Quit()

    contains
    subroutine Render()
        rc = erase()
        rc = move(0, 0)
        select case (turn)
            case (Turn_X)
                rc = addstr("X's turn" // c_null_char)
                
            case (Turn_O)
                rc = addstr("O's turn" // c_null_char)
        end select

        do i = 1, boardSize(1)
            rc = move(1 + i, 0)
            do j = 1, boardSize(2)
                rc = addch(ichar('[', 8))
                
                if ((i == cursor%y) .and. (j == cursor%x)) then
                    rc = attron(A_REVERSE)
                end if
                rc = addch(ichar(boardArray(i, j), 8))
                if ((i == cursor%y) .and. (j == cursor%x)) then
                    rc = attroff(A_REVERSE)
                end if
                
                rc = addch(ichar(']', 8))
            end do
        end do

        rc = move(boardSize(2) + 2, 0)
        if (gameOver) then
            select case (turn)
                case (Turn_X)
                    rc = addstr("X wins" // c_null_char)
                case (Turn_O)
                    rc = addstr("O wins" // c_null_char)
            end select
        end if

        rc = refresh()
    end subroutine Render
end program ygttt