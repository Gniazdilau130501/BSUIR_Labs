public class MatrixMultiplication {
    public static void main(String[] args) {
        int[][] matrix1 = {{1, 2, 3}, {4, 5, 6}};
        int[][] matrix2 = {{7, 8}, {9, 10}, {11, 12}};

        int[][] result = multiplyMatrices(matrix1, matrix2);

        for (int i = 0; i < result.length; i++) {
            for (int j = 0; j < result[0].length; j++) {
                System.out.print(result[i][j] + " ");
            }
            System.out.println();
        }
    }

    public static int[][] multiplyMatrices(int[][] matrix1, int[][] matrix2) {
        int m = matrix1.length;
       // int n = matrix1[0].length;
        int p = matrix2[0].length;

        int[][] result = new int[m][p];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < p; j++) {
                Thread thread = new Thread(new MatrixMultiplier(matrix1, matrix2, result, i, j));
                thread.start();
                try {
                    thread.join();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }

        return result;
    }

    private static class MatrixMultiplier implements Runnable {
        private int[][] matrix1;
        private int[][] matrix2;
        private int[][] result;
        private int row;
        private int col;

        public MatrixMultiplier(int[][] matrix1, int[][] matrix2, int[][] result, int row, int col) {
            this.matrix1 = matrix1;
            this.matrix2 = matrix2;
            this.result = result;
            this.row = row;
            this.col = col;
        }

        @Override
        public void run() {
            int sum = 0;
            for (int i = 0; i < matrix1[0].length; i++) {
                sum += matrix1[row][i] * matrix2[i][col];
            }
            result[row][col] = sum;
        }
    }
}