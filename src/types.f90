module Types
    enum, bind(c) ! Turn
        enumerator :: Turn_X
        enumerator :: Turn_O
    end enum
    
    type :: Vec2_t
        integer :: x, y
    end type
end module Types