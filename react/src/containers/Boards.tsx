import React, { FC } from "react";
import useUserBoards from "../application/use-user-boards";
import Board from "../components/Board";

const Boards: FC = () => {
  const { boards } = useUserBoards();

  return (
    <main>
      {boards.map((board: any) => (
        <Board board={board} key={board.id} />
      ))}
    </main>
  );
};

export default Boards;
