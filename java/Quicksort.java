public class Quicksort {
    public void sort(int[] values) {
        if (values == null || values.length == 0){
            return;
        }
        quicksort(values, 0, values.length - 1);
    }

    private void quicksort(int[] arr, int low, int high) {
        int i = low, j = high;
        int pivot = arr[low + (high-low)/2];

        while (i <= j) {
            while (arr[i] < pivot) {
                i++;
            }
            while (arr[j] > pivot) {
                j--;
            }

            if (i <= j) {
                exchange(arr, i, j);
                i++;
                j--;
            }
        }
        if (low < j)
            quicksort(arr, low, j);
        if (i < high)
            quicksort(arr, i, high);
    }

    private void exchange(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}