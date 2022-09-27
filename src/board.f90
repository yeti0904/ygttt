module Board
    ! variables
    implicit none
    character, dimension(3, 3) :: boardArray

    ! functions
    contains
    subroutine Board_Init()
        integer, dimension(2) :: boardSize
        integer               :: i, j ! iterator
        boardSize = shape(boardArray)

        do i = 1, boardSize(1)
            do j = 1, boardSize(2)
                boardArray(i, j) = " "
            end do
        end do
    end subroutine Board_Init
    
    function Board_Line(player)
        logical               :: Board_Line
        character             :: player
        integer, dimension(2) :: boardSize
        integer               :: i ! iterator

        boardSize = shape(boardArray)

        ! horizontal lines
        do i = 1, boardSize(1)
            if ( &
                (boardArray(i, 1) == player) .and. (boardArray(i, 2) == player) .and. &
                (boardArray(i, 3) == player) &
            ) then
                Board_Line = .true.
                return
            end if
        end do

        ! vertical lines
        do i = 1, boardSize(2)
            if ( &
                (boardArray(1, i) == player) .and. (boardArray(2, i) == player) .and. &
                (boardArray(3, i) == player) &
            ) then
                Board_Line = .true.
                return
            end if
        end do

        ! diagonal lines
        if ( &
            ( &
                (boardArray(1, 1) == player) .and. (boardArray(2, 2) == player) .and. &
                (boardArray(3, 3) == player) &
            ) .or. &
            ( &
                (boardArray(3, 1) == player) .and. (boardArray(2, 2) == player) .and. &
                (boardArray(1, 3) == player) &
            ) &
        ) then
            Board_Line = .true.
            return
        end if

        Board_Line = .false.
    end function Board_Line
end module Board